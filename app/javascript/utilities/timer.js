document.addEventListener('turbolinks:load', function() {
    var timerSelector = document.querySelector('.timer');

    if (timerSelector) {
      timer = timerSelector.dataset.timer
    function startTime() {
      var minutes = 0
      var seconds = 0
      var result = ""
        if (timer > 60) {
          minutes = timerSelector.innerHTML = Math.floor(timer/60)
          seconds = Math.floor(timer) - minutes * 60
          if (seconds < 10) {
            seconds = "0" + seconds
          }
          result = minutes + ":" + seconds
          timerSelector.innerHTML = result
        } else
        if (timer < 60 && timer > 0) {
          minutes = 0
          seconds = timerSelector.innerHTML
          if (seconds < 10) {
            seconds = "0" + seconds
          }
          result = minutes + ":" + seconds
          timerSelector.innerHTML = result
        } else
        if (timer <= 0) {
        window.location.href = window.location.href + '/result'
        return
        }
        timer -= 1
        setTimeout(startTime, 1000);
    }
    startTime();
}
})
