angular.module('Rosen').controller('AllResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    console.log $rootScope
    $rootScope.activeMenu = 'all'
    
    drawChart = (data) ->
      $scope.chartConfig =
        options:  
          chart:
            type: 'spline'
          credits: false
        xAxis: 
          title:
            text: null
        yAxis:
          min: 0
          title: 
            text: "Correct Answers"
        series: [{
          name: "Your Results"
          data: data
        }]
        title:
          text: null

    $scope.stats.$promise.then ->
      drawChart($scope.stats.results)
    
    return true
])
