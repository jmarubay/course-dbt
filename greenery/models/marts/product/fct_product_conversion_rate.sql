WITH final AS(   
    SELECT 
    product_guid
    , product_name
    , checkouts
    , page_views
    , CAST((checkouts / page_views)*100 AS DECIMAL(5, 2)) AS conversion_rate
    FROM {{ ref('fct_product_events_agg') }} 
    ) 
    
SELECT * 
FROM final