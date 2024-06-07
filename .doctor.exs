%Doctor.Config{
  ignore_modules: [
    Xfood.Accounts.User,
    Xfood.Accounts.UserToken,
    Xfood.AccountsFixtures,
    Xfood.Factory,
    Xfood.Mailer,
    Xfood.Repo,
    Xfood.Reports.Export,
    XfoodWeb,
    XfoodWeb.Endpoint,
    XfoodWeb.ErrorHTML,
    XfoodWeb.ErrorJSON,
    XfoodWeb.PageController,
    XfoodWeb.Router,
    XfoodWeb.Telemetry,
  ],
  ignore_paths: [],
  min_module_doc_coverage: 40,
  min_module_spec_coverage: 0,
  min_overall_doc_coverage: 50,
  min_overall_moduledoc_coverage: 80,
  min_overall_spec_coverage: 0,
  exception_moduledoc_required: true,
  raise: false,
  reporter: Doctor.Reporters.Full,
  struct_type_spec_required: true,
  umbrella: false,
  failed: false
}
