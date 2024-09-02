package labels

import data.labels

resource_with_all_labels := {"labels": [
	"cost-center:mock-cost-center",
	"env:mock-environment",
	"repository:mock-repository",
	"team:mock-team",
]}

resource_missing_labels := {"labels": [
	"cost-center:mock-cost-center",
	"team:mock-team",
]}

resource_no_labels := {"labels": []}

test_eval_with_all_labels {
	labels.eval(resource_with_all_labels) == "pass"
}

test_eval_with_missing_labels {
	labels.eval(resource_missing_labels) == "fail"
}

test_eval_with_no_labels {
	labels.eval(resource_no_labels) == "fail"
}

test_eval_skip {
	labels.eval({"labels": {}}) == "fail"
}
