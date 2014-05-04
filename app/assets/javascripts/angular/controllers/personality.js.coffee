angular.module('Rosen').controller('PersonalityResultsCtrl', [
  '$scope', '$rootScope', '$stateParams',
  ($scope, $rootScope, $stateParams) -> 
  
    $rootScope.activeMenu = 'personality'
        
    return true
])
