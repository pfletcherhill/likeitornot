angular.module('Rosen').controller('ResultsCtrl', [
  '$scope', '$rootScope', '$http', '$stateParams', 'User',
  ($scope, $rootScope, $http, $stateParams, User) ->  
   
    # View constants
    $scope.loadingData = true
    
    $rootScope.activeMenu = 'me'
    
    $scope.myStats = User.getStats({uid: $scope.currentUser.uid})
    
    $scope.stats = User.getAllStats()

    return true
])
