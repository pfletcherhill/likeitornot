angular.module('Rosen').controller('MyResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    $rootScope.activeMenu = 'me'
        
    drawChart = (data) ->
      timedData = _.map data, (item) ->
        # return [Date.parse(item[0]), item[1]]
        return [item[1]]
        
      $scope.chartConfig =
        options:  
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
          name: "Your Results"
          data: timedData
        }]
        title:
          text: null

    $scope.myStats.$promise.then ->
      drawChart($scope.myStats.results)
    
    return true
])
