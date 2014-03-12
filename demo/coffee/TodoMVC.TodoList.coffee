'use strict'

TodoMVC.module 'TodoList', (TodoList, App, Backbone, Marionette, $, _) ->

  # TodoList Router
  TodoList.Router = Marionette.AppRouter.extend
      appRoutes:
        "*filter": "filterItems"

  # TodoList Controller
  class TodoList.Controller
    constructor: () ->
      @todoList = new App.Todos.TodoList()

    start: ->
      @showHeader @todoList
      @showFooter @todoList
      @showTodoList @todoList
      @todoList.fetch()

    showHeader: (todoList)->
      header = new App.Layout.Header
        collection: todoList

      App.header.show header

    showFooter: (todoList)->
      footer = new App.Layout.Footer
        collection: todoList

      App.footer.show footer

    showTodoList: (todoList)->
      App.main.show new TodoList.Views.ListView
        collection: todoList

    filterItems: (filter) ->
      App.vent.trigger 'todoList:filter', (filter and filter.trim()) or ''

  # TodoList Initialize
  TodoList.addInitializer ->
    controller = new TodoList.Controller()
    controller.router = new TodoList.Router
      controller: controller

    controller.start()
