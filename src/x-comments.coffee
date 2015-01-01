{ownerDocument} = document._currentScript || document.currentScript

prototype = Object.create HTMLElement.prototype
prototype.createdCallback = ->
  template = ownerDocument.getElementById 'x-comments'
  templateClone = document.importNode template.content, true
  if location.pathname isnt '/' then @appendChild templateClone

document.registerElement 'x-comments',
  prototype: prototype
