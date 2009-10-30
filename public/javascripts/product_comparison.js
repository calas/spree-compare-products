function disableIf(query, value){ $(query).attr('disabled', value); }

function countChecked() { 
    var checkedProducts = $(':checkbox.compare:checked').length;
    disableIf("form[action*='/compare_products'] :submit", (checkedProducts < 2));
}

function directSubmit() {
    var product_id = $.map($(':checkbox.compare:checked'), function(n) {return n.value;}).join('/');
    window.location = '/t/' + $('#taxon')[0].value + '/compare/' + product_id;
    return false;
};

$(function(){
      countChecked();
      $(":checkbox").click(countChecked);
      $("form[action*='/compare_products']").submit(directSubmit);
  });