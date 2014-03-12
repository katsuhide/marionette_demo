'use strict'

TodoMVC.module 'TodoList.Views', (Views, App, Backbone, Marionette, $) ->
	# Todo List Item Views
	class Views.ItemView extends Marionette.ItemView
		tagName: 'li'
		template: '#template-todoItemView'
		ui:
			edit: '.edit'

		events:
			'click .destroy': 'destroy'
			'dblclick label': 'onEditClick'
			'keydown .edit': 'onEditKeypress'
			'focusout .edit': 'onEditFocusout'
			'click .toggle': 'toggle'

		modelEvents:
			'change': 'render'

		onRender: ->
			@$el.removeClass 'active completed'

			if @model.get 'completed' then @$el.addClass 'completed' else @$el.addClass 'active'

		destroy: ->
			@model.toggle().save()

		onEditClick: ->
			@$el.addClass 'editing'
			@ui.edit.focus()
			@ui.edit.val @ui.edit.val()

		onEditFocusout: ->
			todoText = @ui.edit.val().trim()
			if todoText
				@model.set 'title', todoText save()
				@$el.removeClass 'editing'
			else
				@destroy

		onEditKeypress: (e) ->
			ENTER_KEY = 13
			ESC_KEY = 27

			if e.which is ENTER_KEY
				@onEditFocusout()

			if e.which is ESC_KEY
				@ui.edit.val @model.get 'title'
				@$el.removeClass 'editing'


    class Views.ListView extends Backbone.Marionette.CompositeView
		template: '#template-todoListCompositeView'
		itemView: Views.ItemView
		itemViewContainer: '#todo-list'
		ui:
			toggle: '#toggle-all'

		events:
			'click #toggle-all': 'onToggleAllClick'

		collectionEvents:
			'all': 'update'

		onRender: ->
			@update()

		update: ->
			reduceCompleted (left, right)->
				left and right.get 'completed'

			allCompleted = @collection.reduce reduceCompleted, true

			@ui.toggle.prop 'checked' allCompleted
			@$el.parent().toggle !!@collection.length

		onToggleAllClick: (e) ->
			isChecked = e.currentTarget.checked
			@collection.each (todo) ->
				todo.save
					'completed': isChecked



	App.vent.on 'todoList:filter', (filter) ->
		filter = filter or 'all'
		$('#todoapp').attr 'class' , 'filter-' + filter

