String::toTitleCase = ->
  smallWords = /^(a|an|and|as|at|but|by|en|for|if|in|of|on|or|the|to|vs?\.?|via)$/i
  @replace /([^\W_]+[^\s-]*) */g, (match, p1, index, title) ->
    return match.toLowerCase()  if index > 0 and index + p1.length isnt title.length and p1.search(smallWords) > -1 and title.charAt(index - 2) isnt ":" and title.charAt(index - 1).search(/[^\s-]/) < 0
    return match  if p1.substr(1).search(/[A-Z]|\../) > -1
    match.charAt(0).toUpperCase() + match.substr(1)

