function uploadCSV () {
  $("#upload").on("submit", function(event){

    event.preventDefault();
    event.stopPropagation()

    var data = new FormData();

    var file = $('#file')[0].files[0]

    if (typeof file != "undefined"){
    } else {
      return alert("Please select a file to upload")
    }

    data.append('file', file);

    var request = $.ajax({
      type: 'post',
      url: '/home/upload',
      data: data,
      processData: false,
      contentType: false,
    });

    request.done(function(response){
      alert("File uploaded!");
      $(".container").replaceWith(response)
    });

    request.fail(function(response) {
      // alert(JSON.stringify(response))
      alert(response.responseText)
      console.log(response)
    });

  });
}