view: explore_assistant_examples {
  sql_table_name: `explore_assistant.explore_assistant_examples` ;;

  dimension: explore_id {
    type: string
    sql: ${TABLE}.explore_id ;;
  }
  dimension: examples {
    type: string
    sql: ${TABLE}.examples ;;
  }
}
