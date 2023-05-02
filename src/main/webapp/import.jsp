<div class="btn-group pull-right">
	<button class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars"></i> Export Data</button>
	<ul class="dropdown-menu">
		<li><a href="#" onClick ="$('#example1').tableExport({type:'json', tableName:'AlpsExport'});"><img src='dist/img/icons/json.png' width="24"/> JSON</a></li>
		<li class="divider"></li>
		<li><a href="#" onClick ="$('#example1').tableExport({type:'xml', tableName:'AlpsExport'});"><img src='dist/img/icons/xml.png' width="24"/> XML</a></li>
		<li><a href="#" onClick ="$('#example1').tableExport({type:'sql', tableName:'alpsgateway'});"><img src='dist/img/icons/sql.png' width="24"/> SQL</a></li>
		<li class="divider"></li>
		<li><a href="#" onClick ="try{$('#example1').tableExport({type:'excel', escape:'false', exclude: '.noExl', tableName:'AlpsExport'});}catch(err){alert(err.message);}"><img src='dist/img/icons/xls.png' width="24"/> XLS</a></li>
		<li><a href="#" onClick ="$('#example1').tableExport({type:'doc', escape:'false', tableName:'AlpsExport'});"><img src='dist/img/icons/word.png' width="24"/> Word</a></li>
	</ul>
</div>