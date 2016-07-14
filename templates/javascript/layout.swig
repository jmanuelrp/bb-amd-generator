{% extends "../../core/templates/collection.swig" %}

{% block extra-buttons %}
	{% include 'core::btnReload.swig' %}
{% endblock %}

{% block content-header %}
	<div class="box box-solid clear-margin hidden-xs">
		<div class="box-body">
			<div class="padding-rowpanel clearfix">
				<div class="col-xs-4">
					<span class="item-bold">Nombre</span>
				</div>
			</div>
		</div>
	</div>
{% endblock %}
