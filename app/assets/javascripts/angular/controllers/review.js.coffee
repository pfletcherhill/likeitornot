angular.module('Rosen').controller('ReviewCtrl', [
  '$scope', '$state', '$stateParams', '$http', 'User', 'Game', 'Page'
  ($scope, $state, $stateParams, $http, User, Game, Page) ->  
        
    $scope.game.$promise.then ->
      $scope.counts = _.countBy $scope.game.results, (res) ->
        return res.correct == true ? 'true': 'false'
             
    # New Game
    $scope.newGame = ->
      Game.save {userId: $scope.currentUser.uid}, (data) ->
        $state.go('game', {gameId: data.uid})
        
    return true
])
