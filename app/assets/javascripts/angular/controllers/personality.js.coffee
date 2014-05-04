angular.module('Rosen').controller('PersonalityResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    $rootScope.activeMenu = 'personality'
    
    $scope.perc = $scope.myStats.correct_answers / $scope.myStats.total_answers
    if $scope.perc >= .60
      $scope.personality = "accurate"
    else if $scope.perc <= .40
      $scope.personality = "inaccurate"
    else
      $scope.personality = "little"
        
    return true
])
