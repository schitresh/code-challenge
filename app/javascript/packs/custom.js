$(document).ready(function(){
    deletors = $('.deletor')
    deleteEnabler = $('#delete-enabler')

    deleteEnabler.on('click', function(e){
        $(this).text( deleteEnabler.text() == "Delete Companies" ? "Close Deletor" : "Delete Companies" )
        deletors.toggleClass('hidden')
        e.preventDefault();
    })
})
