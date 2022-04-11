var deleteCharId;
var playCharId;
var currentAop = "Blaine County!";
var spawnPoints = [];


window.addEventListener('message', (event)=> {
  data = event.data
  if (data.type == "open"){
	  setCharMenu(data.charData, data.discordRoles)
    $('#charselectbody').fadeIn();
    spawnPoints = data.spawns
  }
  if (data.type == "refresh"){
    setCharMenu(data.newData, data.newRoles)
    spawnPoints = data.spawns
  }
  if (data.type == "aopUpdate"){
    currentAop == data.aop;
  }
  if (data.type == "cfg"){
    console.log(data.conf);
  }
  if (data.type == "close"){ 
    $('#charselectbody').fadeOut(1000);
  }
})

function checkFirstName() {
  var myFirstName = document.getElementById('fname-input');
  var value = myFirstName.value;
  if(value.trim().match(/^[a-zA-Z][0-9a-zA-Z .,'-]*$/) == null) {
    myFirstName.style.backgroundColor = '#E06666';
    myFirstName.style.color = 'black';
  }
  else {
    if(value.length > 0 && value.length < 17) {
      myFirstName.style.backgroundColor = '#B6D7A8';
      myFirstName.style.color = 'black';
    }
    else {
      myFirstName.style.backgroundColor = '#E06666';
      myFirstName.style.color = 'black';
    }
  }
}

function checkLastName() {
  var myLastName = document.getElementById('lname-input');
  var value = myLastName.value;
  if(value.trim().match(/^[a-zA-Z][0-9a-zA-Z .,'-]*$/) == null) {
    myLastName.style.backgroundColor = '#E06666';
    myLastName.style.color = 'black';
  }
  else {
    if(value.length > 0 && value.length < 17) {
      myLastName.style.backgroundColor = '#B6D7A8';
      myLastName.style.color = 'black';
    }
    else {
      myLastName.style.backgroundColor = '#E06666';
      myLastName.style.color = 'black';
    }
  }
}

function checkSex() {
  var sex = document.getElementById("sex-input")
  var val = sex.value;

  if (val == "--Select One--") {
    sex.style.backgroundColor = "#E06666";
  } else {
    sex.style.backgroundColor = "#B6D7A8";
  }
}

function checkDOB() {
  var myDOB = document.getElementById('dob-input');
  var date = new Date($('#dob-input').val());
  day = date.getDate();
  month = date.getMonth() + 1;
  year = date.getFullYear();
  if (isNaN(month) || isNaN(day) || isNaN(year)) {
    myDOB.style.backgroundColor = '#E06666';
    myDOB.style.color = 'black';
  }
  else {
    var dateInput = [month, day, year].join('/');

    var regExp = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
    var dateArray = dateInput.match(regExp);

    if (dateArray == null){
      return false;
    }

    month = dateArray[1];
    day= dateArray[3];
    year = dateArray[5];        

    if (month < 1 || month > 12){
      myDOB.style.backgroundColor = '#E06666';
      myDOB.style.color = 'black';
    }
    else if (day < 1 || day> 31) { 
      myDOB.style.backgroundColor = '#E06666';
      myDOB.style.color = 'black';
    }
    else if ((month==4 || month==6 || month==9 || month==11) && day ==31) {
      myDOB.style.backgroundColor = '#E06666';
      myDOB.style.color = 'black';
    }
    else if (month == 2) {
      var isLeapYear = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
      if (day> 29 || (day ==29 && !isLeapYear)){
        myDOB.style.backgroundColor = '#E06666';
        myDOB.style.color = 'black';
      }
    }
    else {
      myDOB.style.backgroundColor = '#B6D7A8';
      myDOB.style.color = 'black';	
    }				
  }
}


// Button footer
/*footer:"<hr/><div class=\"btn-group w-100\" role=\"group\"><button data-id=\"4\" type=\"button\" class=\"prop-action-single btn btn-sm btn-info\">Play <i class=\"fa fa-play\"></i></button><button data-id=\"4\" type=\"button\" class=\"prop-action-multiple btn btn-sm btn-primary\">Delete <i class=\"fa fa-trash\"></i></button></div>", */

function toggleCreateNewChar() {
  var element = document.getElementById("new-char-prompt");
  var state = element.style.display;
  if (state == "none"){
    $('#new-char-prompt').fadeIn(350);
  } else if (state == "block") {
    $('#new-char-prompt').fadeOut(150);
    $('#error').fadeOut(150);
  } else if (state == "") {
    $('#new-char-prompt').fadeIn(350);
  }
}

document.getElementById("confirmedDel").onclick = function() {
  $.post("https://gs-core/deleteChar", JSON.stringify(deleteCharId))
  $('#delete-dialog').modal('hide');
  setTimeout(() => { refresh(); }, 200);
  
}

document.getElementById("CreateCharacter").onclick = function() {
  var fname = document.getElementById("fname-input").value;
  var lname = document.getElementById("lname-input").value;
  var sex = document.getElementById("sex-input").value;
  var dob = document.getElementById("dob-input").value;
  var dept = document.getElementById("dept-input").value;
  $('#error').empty();


  if (!(fname == "" || lname == "" || sex == "--Select One--" || dob == "" || dept == "")){
    if (sex == "male") {
      sex = "M";
    } else if (sex == "female"){
      sex = "F";
    } else if (sex == "other") {
      sex = "O";
    } else {
      sex = "?";
    }

    var charData = JSON.stringify({ fname: fname, lname: lname, sex: sex, dob: dob, dept: dept});

    $.post("https://gs-core/registerChar", charData)
    
    toggleCreateNewChar();
    clearFields();
    setTimeout(() => { refresh(); }, 250);
  } else {
    document.getElementById("error").style.display = "block";
    $('#error').append('<i class="fas fa-exclamation-triangle"></i> One or more fields have been left blank, make sure you have filled out all fields, selected your sex, and set your date of birth.');
  }
}

$('#new-char-prompt').submit(function(event){
  event.preventDefault();

  document.getElementById("new-char-prompt").reset();
  $('#new-char-prompt').hide();
});

function clearFields() {
  document.getElementById("fname-input").value="";
  document.getElementById("lname-input").value="";
  document.getElementById("sex-input").value ="--Select One--";
  document.getElementById("dob-input").value ="";
  document.getElementById("dept-input").value = "CIV";
  document.getElementById("fname-input").style.backgroundColor= "white";
  document.getElementById("lname-input").style.backgroundColor= "white";
  document.getElementById("sex-input").style.backgroundColor= "white";
  document.getElementById("dob-input").style.backgroundColor= "white";
  document.getElementById("dept-input").style.backgroundColor= "white";
}

function playChar(cid, dept) {
  $('.spawnbuttons').remove();
  $('#aop').empty();
  $.each(spawnPoints, function(index, spawn){
    if (dept == index){
      $.each(spawn, function(index, location){
        $('#spawn-body').append('<button type="button" id="spawn-'+index+'" class="btn btn-primary spawnbuttons" onclick="playCharConfirm(this.id)">'+location.label+'</button>');
        $('#spawn-'+index+'').data("spawnLoc", location);
      })
    }
  })
  $('#aop').append('AOP: '+currentAop+'')
  playCharId = cid;
}

function playCharConfirm(element) {
  var spawn = $('#'+element).data("spawnLoc")
  $('#spawn-dialog').modal('hide');
  $.post("https://gs-core/selectChar", JSON.stringify({loc: {x: spawn.x, y: spawn.y, z: spawn.z}, charid: playCharId}))
}

function deleteChar(cid, fname, lname, dept) {
  $('.delete-titles').remove();
  $('.modal-head-delete').append('<h5 class="modal-title delete-titles" id="delete-confirm-text">Are you sure you want to delete '+fname+' '+lname+' ('+dept+')?</h5>');
  deleteCharId = cid;
}

function dc() {
  $.post("https://gs-core/disconnect")
}

function refresh() {
  $.post("https://gs-core/refresh")
}

function setCharMenu(dataChars, dataDisc){
    $(".allcharsclass").fadeOut().remove();
    $.each(JSON.parse(dataChars), function(index, char) {
      if (!$('#'+char.charid+'').length) {
        $('#charsbody').append('<li class="json-list-item'+ index +' list-group-item json-item-header collapsed allcharsclass" data-toggle="collapse" id="'+ char.charid +'" href="#jsonItem'+index+'" role="button" aria-expanded="false">'+ char.fname + " " + char.lname+' ('+char.department+')<div id="jsonItem'+ index +'" class="json-item-body collapse"><hr><div class="btn-group w-100" role="group"><button type="button" class="btn btn-primary" onclick="playChar('+char.charid+',\''+char.department+'\')" data-toggle="modal" data-target="#spawn-dialog">Play <i class="fa fa-play"></i></button><button type="button" class="btn btn-primary btn-red" data-toggle="modal" data-target="#delete-dialog" onclick="deleteChar(\''+char.charid+'\',\''+char.fname+'\',\''+char.lname+'\',\''+char.department+'\')">Delete <i class="fa fa-trash"></i></button></div></div>');
        $('.json-list-item'+index+'').hide().fadeIn();
      }
    });
    $('.dept-inputs').remove();
    $('#dept-input').append('<option class="dept-inputs" value="CIV">Civilian</option>')
    $.each(JSON.parse(dataDisc), function(index, roleid) {
      if(roleid == '709830958244954137') {
        $('#dept-input').append('<option class="dept-inputs" value="LSPD">LSPD</option>');
      } else if (roleid == '709830958232371207') {
        $('#dept-input').append('<option class="dept-inputs" value="BCSO">BCSO</option>');
      } else if (roleid == '709830958215463002') {
        $('#dept-input').append('<option class="dept-inputs" value="SAST">SAST</option>');
      } else if (roleid == '709830958211137556'){
        $('#dept-input').append('<option class="dept-inputs" value="SAFR">SAFR</option>');
      };
    });

}