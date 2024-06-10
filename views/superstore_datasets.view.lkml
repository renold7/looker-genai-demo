# The name of this view in Looker is "Superstore Datasets"
view: superstore_datasets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
# <<<<<<< HEAD
  sql_table_name: `dla_data_governance.superstore_datasets` ;;
#     ;;
# >>>>>>> branch 'master' of ../../bare_models/genai_demo.git
#   # No primary key is defined for this view. In order to join this view in an Explore,
#   # define primary_key: yes on a dimension that has no repeated values.

#   # Here's what a typical dimension looks like in LookML.
#   # A dimension is a groupable field that can be used to filter query results.
#   # This dimension will be called "Category" in Explore.

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    type: sum
    drill_fields: [region, country, total_cost]
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  # drill_fields: [region, country, city, mtotal_profit]


  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: gmv {
    type: number
    sql: ${TABLE}.gmv ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  measure: test {
    type: number
    sql: SUM(${total_profit})/COUNT(DISTINCT ${order_month}) ;;
  }

  dimension: lon {
    type: number
    sql: ${TABLE}.lon ;;
  }

  dimension: latlong {
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lon} ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: month_format {
    group_label: "Created date"
    label: "Date"
    type: date_raw
    sql: ${order_date} ;;
    html: {{ rendered_value | date: "%B" }};;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: regiongroup {
    type: string
    sql: CASE
            WHEN ${TABLE}.region in ('Central', 'North') THEN 'A'
            WHEN ${TABLE}.region in ('Central', 'South') THEN 'B'
        END;;

  }

  dimension_group: ship {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ship_date ;;
  }


  # parameter: region_param {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Central"
  #     value: "Central"
  #   }
  #   allowed_value: {
  #     label: "North"
  #     value: "North"
  #   }
  #   allowed_value: {
  #     label: "South"
  #     value: "South"
  #   }
  # }

  # parameter: category_param {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Office Supplies"
  #     value: "Office Supplies"
  #   }
  #   allowed_value: {
  #     label: "Technology"
  #     value: "Technology"
  #   }
  #   allowed_value: {
  #     label: "Furniture"
  #     value: "Furniture"
  #   }
  # }


  parameter: dim_param {
    type: unquoted
    allowed_value: {
      label: "Region"
      value: "region"
    }
    allowed_value: {
      label: "Category"
      value: "category"
    }
    allowed_value: {
      label: "Sub_category"
      value: "sub_category"
    }
  }

  dimension: dim_opt1 {
    type: string
    sql: ${TABLE}.{% parameter dim_param %} ;;
  }

  parameter: item_to_add_up {
    type: unquoted
    allowed_value: {
      label: "Total GMV"
      value: "total_gmv"
    }
    allowed_value: {
      label: "Total Profit"
      value: "total_profit"
    }
  }

  measure: dynamic_sum {
    type: sum
    sql: ${TABLE}.{% parameter item_to_add_up %} ;;
    value_format_name: "usd"
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.ship_mode ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  # dimension: total_cost {
  #   type: number
  #   sql: ${TABLE}.total_cost ;;
  # }

  dimension: total_gmv {
    type: number
    sql: ${TABLE}.total_gmv ;;
  }

  dimension: total_profit {
    type: number
    sql: ${TABLE}.total_profit ;;
  }

  measure: show_total {
    type: number
    drill_fields: [region, country, mtotal_profit]
    value_format: " [>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0"
    sql: sum(${mtotal_profit}) over() ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name]
  }

  measure: check {
    type: count_distinct
    sql: ${TABLE}.region ;;
  }

  measure: mtotal_profit {
    type: sum
    drill_fields: [region, country, city_with_liquid, mtotal_profit]
    sql: ${total_profit} ;;
  }

  measure: mtotal_profit_with_liquid {
    type: sum
    link: {
      label: "Status Total Provit"
      url: "https://datalabs.cloud.looker.com/embed/dashboards/14?MONTH=&CITY={value}&YEAR="
    }
    sql: ${total_profit} ;;
  }


  dimension: city_with_liquid {
    type: string
    sql: ${city} ;;
    link: {
      label: "success"
      url: "https://datalabs.cloud.looker.com/embed/dashboards/34?City={{value}}"
      icon_url: "https://cdn.iconscout.com/icon/free/png-512/free-check-verified-successful-accept-tick-yes-success-2516.png?f=avif&w=256"
    }
    link: {
      label: "Fail"
      url: "https://datalabs.cloud.looker.com/embed/dashboards/36?City={{value}}"
      icon_url: "https://cdn.iconscout.com/icon/premium/png-512-thumb/fail-5156466-4302609.png?f=avif&w=256"
    }
  }

  dimension: numb {
    type:  number
    sql: CASE WHEN ${country} = "France" THEN 1
          ELSE 2
          END;;
  }

  parameter: selected {
    required_fields: [cities_liquid]
  }

  dimension: cities_liquid {
    type: number

    link: {

      label: "Status Total Provit"
      url:"https://datalabs.cloud.looker.com/embed/dashboards/14?MONTH=&CITY={{value}}&YEAR="
    }
    sql: ${numb} ;;
  }


  measure: mtotal_gmv {
    type: sum
    drill_fields: [region, country, mtotal_gmv]
    value_format: " [>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0"
    sql: ${total_gmv} ;;
  }

  measure: total_order {
    type: count_distinct
    sql: ${order_id} ;;
    drill_fields: [order_date, total_profit]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"stacking\" : \"\",
      \"show_value_labels\" : false,
      \"label_density\" : 25,
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : true,
      \"y_axis_gridlines\" : true,
      \"show_view_names\" : false,
      \"limit_displayed_rows\" : false,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\" : false,
      \"show_x_axis_ticks\" : true,
      \"x_axis_scale\" : \"auto\",
      \"y_axis_scale_mode\" : \"linear\",
      \"show_null_points\" : true,
      \"point_style\" : \"circle\",
      \"ordering\" : \"none\",
      \"show_null_labels\" : false,
      \"show_totals_labels\" : false,
      \"show_silhouette\" : false,
      \"totals_color\" : \"#808080\",
      \"type\" : \"looker_scatter\",
      \"interpolation\" : \"linear\",
      \"series_types\" : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\" : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\" : \"#000000\",
      \"label_position\" : \"left\",
      \"period\" : 30,
      \"regression_type\" : \"average\",
      \"series_index\" : 1,
      \"show_label\" : true,
      \"label_type\" : \"string\",
      \"label\" : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: prev_profit {
    type: sum
    sql: ${total_profit} ;;
    filters: [order_date: "10 year ago"]
  }

  measure: prev11_profit {
    type: sum
    sql: ${total_profit} ;;
    filters: [order_date: "11 year ago"]
  }

  measure: provit_growth {
    type: number
    sql: (${prev_profit}-${prev11_profit})/${prev_profit} ;;
  }

  dimension: max_date {
    type: date
    sql: MAX(${order_date}) ;;
  }

  measure: filter_max_date {
    type: yesno
    sql: ${order_date}=MAX(${order_date})  ;;
  }

  dimension: view {
    type: string
    sql: ${city} ;;
    html: <div style="font-size:10px; text-transform:capitalize;"><br>
          <Link href="https://datalabs.cloud.looker.com/looks/2">
          <div>;;
  }

### TEST 2 Month ###

  # dimension: days_until_next_order {
  #   label: "Days Until Next Order"
  #   type: number
  #   # view_label: "Repeat Purchase Facts"
  #   sql: TIMESTAMP_DIFF(${order_date},current_date(), MONTH) ;;
  # }

  parameter: param2m {
    type: string
    allowed_value: {
      label: "Repeat Orders within 2 Month"
      value: "count_with_repeat_purchase_within_60d"
    }
    allowed_value: {
      label: "Repeat Orders within 6 Month"
      value: "count_with_repeat_purchase_within_6m"
    }
  }

  dimension: days_until_next_order {
    label: "Month Until Next Order"
    type: number
    # view_label: "Repeat Purchase Facts"
    sql: EXTRACT(MONTH FROM current_date())-EXTRACT(MONTH FROM ${order_date}) ;;
  }

  dimension: repeat_orders_within_60d {
    label: "Repeat Orders within 2 Month"
    type: yesno
    # view_label: "Repeat Purchase Facts"
    sql: ${days_until_next_order} <= 2 AND ${days_until_next_order} >= 0;;
  }

  dimension: repeat_orders_within_6m{
    label: "Repeat Orders within 6 Month"
    type: yesno
    sql:  ${days_until_next_order} <= 6 AND ${days_until_next_order} >= 0;;
  }

  measure: count_with_repeat_purchase_within_60d {
    # label: "Count with Repeat Purchase within 2 Month"
    type: sum
    sql: ${TABLE}.total_profit ;;
    # view_label: "Repeat Purchase Facts"

    filters: {
      field: repeat_orders_within_60d
      value: "Yes"
    }
  }

  measure: count_with_repeat_purchase_within_6m {
    label: "Count with Repeat Purchase within 6 Month"
    type: sum
    sql: ${TABLE}.total_profit ;;
    # view_label: "Repeat Purchase Facts"

    filters: {
      field: repeat_orders_within_6m
      value: "Yes"
    }
  }

  measure: Sum2M {
    label: "Sum 2 Month"
    type: number
    sql: CASE
          WHEN {% parameter param2m %} = "count_with_repeat_purchase_within_60d" THEN ${count_with_repeat_purchase_within_60d}
          WHEN {% parameter param2m %} = "count_with_repeat_purchase_within_6m" THEN ${count_with_repeat_purchase_within_6m}
          END;;
          # value_format_name: "usd"
    }

### ===== ###


### Test Param ###

    parameter: paramyear {
      type: unquoted
      allowed_value: {
        label: "2014"
        value: "2014"
      }
      allowed_value: {
        label: "2013"
        value: "2013"
      }
    }

    dimension: paramyear_2_year{
      label: "Year2"
      type: yesno
      # view_label: "Repeat Purchase Facts"
      sql: ${year} Is NOT NULL ;;
    }

    dimension: year {
      type: string
      sql: CASE
            WHEN {% parameter paramyear %} = ${order_year} THEN {% parameter paramyear %}
            WHEN {% parameter paramyear %}-1 = ${order_year} THEN {% parameter paramyear %}-1
          END;;
    }


### ===== ###


### Test SET ###

    set: try_set  {
      fields: [
        region,
        category
      ]
    }

### ===== ###

    dimension: area {
      map_layer_name: uk_postcode_areas
      sql: ${city} ;;
    }

    dimension: Status {
      type: string
      sql: case when ${TABLE}.profit >= 75 then "success"
              when ${TABLE}.profit <= 74 then "Fail"
              end;;

    }
    measure: jumal_order {
      type: count_distinct
      sql: ${TABLE}.order_id ;;
    }

    measure: jumlah_order {
      type: count_distinct
      sql: ${TABLE}.order_id ;;
    }

  }
