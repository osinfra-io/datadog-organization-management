package labels

import rego.v1

required_labels := ["cost-center", "team", "env", "repository"]

parse_labels(resource) := {label_key |
	some i
	label := resource.labels[i]
	parts := split(label, ":")
	label_key := parts[0]
}

all_required_labels_present(resource) if {
	parsed_labels := parse_labels(resource)
	count({label | label := required_labels[_]; not label in parsed_labels}) == 0
}

eval(resource) := result if {
	skip := false
	not skip
	all_required_labels_present(resource)
	result = "pass"
} else := result if {
	result = "fail"
}
