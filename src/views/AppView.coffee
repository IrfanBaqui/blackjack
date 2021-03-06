class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="result"><h1></h1></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>

  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': 'stdBtnClicked'

  stdBtnClicked: ->
    @model.get('playerHand').stand()
    @model.get('dealerHand').stand()

  initialize: ->
    @render()
    @model.on 'playerWins dealerWins push', ((triggerName) ->
      if triggerName == 'playerWins'
        triggerName = 'You Win'
      else if triggerName == 'dealerWins'
        triggerName = 'You Lose'
      else
        triggerName = 'Push'
      renderResult triggerName
      return
    ), this


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderResult = (result) ->
    @$('.result h1').text result
    return
