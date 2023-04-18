output "compartment" {
  description = "Compartiment"
  value       = oci_identity_compartment.create_compartment
}

output "compartment_id" {
  description = "Compartiment ID"
  value       = oci_identity_compartment.create_compartment.id
}
