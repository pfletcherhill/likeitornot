angular.module('Rosen').controller('PageCtrl', [
  '$scope', '$stateParams', '$http', 'Page',
  ($scope, $stateParams, $http, Page) ->  
      
    $scope.page = new Page $scope.result.page
    
    $scope.toggleAnswer = ->
      $scope.result.answer = !$scope.result.answer
    
    return true
])
