{% extends "../../core/templates/rowPanel.swig" %}

{% block titles %}
	<div class="col-xs-4">
		{{ nombre }}
	</div>
{% endblock %}

{% block title %}
	<div class="col-xs-12">
		<b>{{ nombre }}</b>
	</div>
{% endblock %}

{% block content %}
	<div class="visible-xs-block">
		<h5>Nombre</h5>
		<p>{{ nombre }}</p>
	</div>
	<h5>Atributo</h5>
	<p>{{ atributo|default('--') }}</p>
{% endblock %}
