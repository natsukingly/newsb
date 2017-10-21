$('.article').hover(
  function () {
    $(this).find('h2').css("color", "rgb(54, 88, 155)");
  },
  function () {
  	$(this).find('h2').css("color", "#000");
  }
);