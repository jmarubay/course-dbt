{% macro event_types(column_name) %}

    {% set sql %}
    set event_types = dbt_utils.get_column_values(
        table = ref('int_events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    ) 
    {% endset %}

{% endmacro %}