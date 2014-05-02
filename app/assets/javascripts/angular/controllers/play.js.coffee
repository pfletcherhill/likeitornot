angular.module('Rosen').controller('PlayCtrl', [
  '$scope', '$state', '$stateParams', '$http', 'User', 'Game', 'Page'
  ($scope, $state, $stateParams, $http, User, Game, Page) ->  
   
    # View constants
    $scope.loadingData = true
    
    # Game
    $scope.game = Game.get
      userId: $scope.currentUser.uid
      uid: $stateParams.gameId      
    
    # Submit answers (results) and transition to review state
    $scope.submitAnswers = ->
      $scope.game.$submitResults userId: $scope.currentUser.uid, (data) ->
        $state.go('game.review', {gameId: data.uid})
        
    return true
])
