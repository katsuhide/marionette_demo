// Generated by CoffeeScript 1.7.1
var TodoMVC;

this.TodoMVC = TodoMVC = new Backbone.Marionette.Application();

TodoMVC.addRegions({
  header: "#header",
  main: "#main",
  footer: "#footer"
});

TodoMVC.on("initialize:after", (function(_this) {
  return function() {
    return Backbone.history.start();
  };
})(this));
