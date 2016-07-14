{% extends "../../core/templates/rowPanelEdit.swig" %}

{% block content %}
	<form role="form" class="pieel-form">
		<div class="col-md-4 form-group">
			<label class="control-label">
				Nombre
			</label>
			<div class="">
				<input type="text" name="nombre" value="" class="form-control" placeholder="Nombre"/>
			</div>
		</div>
	</form>
{% endblock %}
