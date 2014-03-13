'use strict'

TodoMVC.module 'Layout', (Layout, App, Backbone) ->

	# Layout Header
	class Layout.Header extends Backbone.Marionette.ItemView
		template: '#template-header'

		ui:
			input: '#new-todo'

		events:
			'keypress #new-todo': 'onInputKeypress'

		onInputKeypress: (e) ->
			ENTER_KEY = 13
			todoText = @ui.input.val().trim()

			@createTodo todoText if e.which is ENTER_KEY and todoText

		completeAdd: ->
			@ui.input.val('')

		createTodo : (todoText) ->
			return if todoText.trim() is ''

			@collection.create
				title: todoText

			@completeAdd()

	# Layout Footer
	class Layout.Footer extends Backbone.Marionette.ItemView

		template: '#template-footer'

		ui:
			filters: '#filters a'

		events:
			'click #clear-completed': 'onClearClick'

		collectionEvents:
			'all': 'render'

		templateHelpers :
			activeCountLabel: ->
				(if @activeCount is 1 then 'item' else 'items') + 'left'

		initialize: ->
			@listenTo App.vent, 'todoList:filter', @updateFilterSelection, @

		serializeData: ->
			active = @collection.getActive().length
			total = @collection.length
			@completedCount(active, total)

		completedCount: (active, total)->
			activeCount: active
			totalCount: total
			completedCount: total - active

		onRender: ->
			@$el.parent().toggle @collection.length > 0
			@updateFilterSelection()

		updateFilterSelection: ->
			@ui.filters
				.removeClass 'selected'
				.filter '[hres="' + (location.hash or '#') + '"]'
				.addClass 'selected'

		onClearClick: ->
			completed = @collection.getCompleted()
			completed.forEach (todo) ->
				todo.destroy()