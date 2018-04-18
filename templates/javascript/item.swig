{% extends "../../core/templates/cardListItem.swig" %}

{% block content %}
	<div class="col-sm-4 hidden-xs">
		{{ nombre }}
	</div>

	<div class="visible-xs">
		<div class="lgi-heading">
			{{ nombre }}
		</div>
		<div class="lgi-text"></div>
	</div>
{% endblock %}
