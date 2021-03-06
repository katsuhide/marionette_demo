// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TodoMVC.module("TodoList", function(TodoList, App, Backbone, Marionette, $, _) {
  TodoList.Router = Marionette.AppRouter.extend({
    appRoutes: {
      "*filter": "filterItems"
    }
  });
  TodoList.Controller = (function(_super) {
    __extends(Controller, _super);

    function Controller() {
      this.todoList = new App.Todos.TodoList();
    }

    Controller.prototype.start = function() {
      this.showHeader(this.todoList);
      this.showFooter(this.todoList);
      this.showTodoList(this.todoList);
      return this.todoList.fetch();
    };

    Controller.prototype.showHeader = function(todoList) {
      var header;
      header = new App.Layout.Header({
        collection: todoList
      });
      return App.header.show(header);
    };

    Controller.prototype.showFooter = function(todoList) {
      var footer;
      footer = new App.Layout.Footer({
        collection: todoList
      });
      return App.footer.show(footer);
    };

    Controller.prototype.showTodoList = function(todoList) {
      return App.main.show(new TodoList.Views.ListView({
        collection: todoList
      }));
    };

    Controller.prototype.filterItems = function(filter) {
      return App.vent.trigger("todoList:filter", filter && filter.trim() || "");
    };

    return Controller;

  })(Backbone.Wreqr.EventAggregator);
  return TodoList.addInitializer(function() {
    var controller;
    controller = new TodoList.Controller();
    new TodoList.Router({
      controller: controller
    });
    return controller.start();
  });
});
