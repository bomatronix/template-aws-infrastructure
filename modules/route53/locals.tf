locals {

  records = concat(var.records, try(jsondecode(var.records_jsonencoded), []))

  # Convert `records` from list to map with unique keys
  recordsets = { for rs in local.records : try(rs.key, join(" ", compact(["${rs.name} ${rs.type}", try(rs.set_identifier, "")]))) => rs }
}
