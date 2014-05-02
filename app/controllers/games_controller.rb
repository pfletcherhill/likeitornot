class GamesController < ApplicationController
  
  def create
    user = User.find_by(uid: params[:user_id])
    game = Game.create(user: user)
    respond_to do |format|
      format.json {render json: game, status: 200}
    end
  end
  
  def show
    game = Game.find_by(uid: params[:id])
    respond_to do |format|
      format.json {render json: game, status: 200}
    end
  end
  
  def update
    user = User.find_by(uid: params[:user_id])
    game = Game.find_by(uid: params[:id])
    params[:results].each do |res|
      result = Result.find_by(id: res["id"])
      result.evaluate_answer(user, res["answer"])
    end
    game.done = true
    respond_to do |format|
      if game.save
        format.json {render json: game, status: 200}
      else
        format.json {render json: {error: "Unable to update game"}, status: 500}
      end
    end
  end
  
  def submit_answers
    user = User.find_by(uid: params[:user_id])
    @results = user.evaluate_answers(params[:answers])
    respond_to do |format|
      if @results
        format.json {render json: @results.as_json({methods: [:result]}), status: 200}
      else
        format.json {render json: {error: "Unable to evaluate answers"}, status: 500}
      end
    end
  end
  
end
