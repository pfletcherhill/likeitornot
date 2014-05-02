angular.module('Rosen').controller('MainCtrl', [
  '$scope', '$state', '$http', 'User', 'Game',
  ($scope, $state, $http, User, Game) ->  
   
    # View constants
    $scope.loadingData = true
    
    # New Game
    $scope.newGame = ->
      Game.save {userId: $scope.currentUser.uid}, (data) ->
        $state.go('game', {gameId: data.uid})
          
    return true
])

