window.Labels = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('#rootEl');
    var router = new Labels.Routers.AppRouter({ $rootEl: $rootEl });
    Backbone.history.start();
    // alert('Hello from Backbone!');
  }
};

$(document).ready(function(){

  Labels.initialize();
});
