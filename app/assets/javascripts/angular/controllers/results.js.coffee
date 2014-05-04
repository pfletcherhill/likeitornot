angular.module('Rosen').controller('ResultsCtrl', [
  '$scope', '$http', '$stateParams', 'User',
  ($scope, $http, $stateParams, User) ->  
   
    # View constants
    $scope.loadingData = true
    
    # Active results
    $scope.personalResults = true
    
    $scope.myStats = User.getStats({uid: $scope.currentUser.uid})
    
    $scope.stats = User.getAllStats()

    return true
])
