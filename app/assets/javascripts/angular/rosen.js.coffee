rosen = angular.module('Rosen', ['ngResource', 'ui.router', 'highcharts-ng', 'ngStorage', 'ui.bootstrap'])
  .config(['$stateProvider', '$locationProvider', '$urlRouterProvider',
    ($stateProvider, $locationProvider, $urlRouterProvider) ->
      $stateProvider
        .state('main',
          url: '/'
          templateUrl: '/templates/index'
          controller: 'MainCtrl'
          resolve:
            currentUser: ($window, authService) ->
              authService.ensureCurrentUser()   
        )     
        .state('game',
          url: '/play/:gameId'
          templateUrl: '/templates/play'
          controller: 'PlayCtrl'
          resolve:
            currentUser: ($window, authService) ->
              authService.ensureCurrentUser()
        )
        .state('game.review',
          url: '/review'
          templateUrl: '/templates/review'
          controller: 'ReviewCtrl'
        )      
        .state('main.results',
          url: 'results'
          templateUrl: '/templates/results'
          controller: 'ResultsCtrl'
        )
      $locationProvider.html5Mode(true)
      $urlRouterProvider.otherwise('/')
  ])
    
  .config(['$httpProvider', ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = 
      angular.element('meta[name=csrf-token]').attr('content');
  ])
  
  # .config(['ezfbProvider', (ezfbProvider) ->
  #     ezfbProvider.setInitParams
  #       appId: '467674363363838'
  #   ])
  #   
  .run(['$rootScope', '$timeout', ($rootScope, $timeout) ->
    # Add additional initialization code here
    # Globally keeps track of whether the right bar is open or closed.
    # $rootScope.timelineOpen = true
  ])
