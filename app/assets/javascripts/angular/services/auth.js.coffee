# The authService stores the currentUser in the rootScope so all scopes
# automatically have access. 
angular.module('Rosen').factory('authService', [
  '$q', '$rootScope', '$window', 'User',
  ($q, $rootScope, $window, User) ->
    return {
      ensureCurrentUser: ->
        deferred = $q.defer()
        if $rootScope.currentUser
          deferred.resolve($rootScope.currentUser)
        else
          User.fetchMe (data) ->
            $rootScope.currentUser = data # Store currentUser 
            deferred.resolve(data)
          , ->
            #$window.location.href = "/login" # Redirect to login
            deferred.reject()
    }
])
