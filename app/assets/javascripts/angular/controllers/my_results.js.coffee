angular.module('Rosen').controller('MyResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    $rootScope.activeMenu = 'me'
        
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

    $scope.myStats.$promise.then ->
      drawChart($scope.myStats.results)
    
    return true
])
