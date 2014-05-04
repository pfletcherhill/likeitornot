angular.module('Rosen').controller('AllResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    $rootScope.activeMenu = 'all'
    
    drawChart = (data) ->
      timedData = _.map data, (item) ->
        return [item[1]]
        
      $scope.chartConfig =
        options: 
          series:
            animation: true
          chart:
            type: 'spline'
          credits: false
          xAxis: 
            title: 
              text: null
            labels:
              enabled: false
          yAxis:
            min: 0
            title: 
              text: "Number of Correct Answers"
          tooltip: 
            formatter: ->
              return 'You got <b>' + this.y + '</b> of <b>9</b> correct'
        series: [{
          color: 'green'
          name: "Your Results"
          data: timedData
        }]
        title:
          text: null
          
    $scope.stats.$promise.then ->
      drawChart($scope.stats.results)
    
    return true
])
