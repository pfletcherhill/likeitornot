angular.module('Rosen')
  # User resource
  .factory('User', ['$resource', '$http', ($resource, $http) ->
    User = $resource '/users/:uid',
      {uid: '@uid'},
      {
        update: {method: 'PUT'}
        fetchMe: {method: 'GET', url: '/me'}
      }
    return User
  ])
  
  # Game resource
  .factory('Game', ['$resource', '$http', ($resource, $http) ->
    Game = $resource '/users/:userId/games/:uid',
      {userId: '@userId', uid: '@uid'}, 
      {submitResults: {method: 'PUT'}}
    return Game
  ])
  
  # Page resource
  .factory('Page', ['$resource', '$http', ($resource, $http) ->
    Page = $resource '/pages/:uid',
      {uid: '@uid'}, {}
    return Page
  ])
