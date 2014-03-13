
TodoMVC.module 'TodoList.Views', (Views, App, Backbone, Marionette, $, _) ->

	class Views.ItemView extends Marionette.ItemView
		tagName: 'li'

		onEditKeypress: (e) ->
			ENTER_KEY = 13
			ESC_KEY = 27

			if e.which is ENTER_KEY
				@onEditFocusout()

			if e.which is ESC_KEY
				@ui.edit.val @model.get 'title'
				@$el.removeClass 'editing'

		onEditKeypress: (e) ->
			ENTER_KEY = 13

