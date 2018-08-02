document.addEventListener("turbolinks:load", function(){
  var country = document.getElementById("user_country");
  var state = document.getElementById("user_state");

  country.addEventListener("change", function(){
    $.ajax({
      url: "/states?country=" + country.value,
      type: "GET"
    })
  })

  state.addEventListener("change", function(){
    $.ajax({
      url: "/cities?country=" + country.value + "&state=" + state.value,
      type: "GET"
    })
  })
})