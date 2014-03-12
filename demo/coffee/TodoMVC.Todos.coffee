'use strict'

TodoMVC.module 'Todos', (Todos, App, Backbone) ->

	# Todo Model
	class Todos.Todo extends Backbone.Model
		defaults:
			title: ''
			completed: false
			created: 0

		initialize: ->
			if @isNew then @set 'created', Date.now()

		toggle: ->
			@set 'completed', !@isCompleted()

		isCompleted: ->
			@get 'completed'

	# Todo Collection
	class Todos.TodoList extends Backbone.Collection
		model: Todos.Todo

		localStorage: new Backbone.LocalStorage 'todos-backbone-marionette'

		getCompleted: ->
			@filter @._isCompleted

		getActive: ->
			@reject @._isCompleted

		comparator: (todo) ->
			todo.get 'created'

		_isCompleted: (todo) ->
			todo.isCompleted()
