Feature: negative testing

  # @author jhou@redhat.com
  # @author lxia@redhat.com
  @admin
  @singlenode
  @proxy @noproxy @disconnected @connected
    @s390x @ppc64le @heterogeneous @arm64 @amd64
  @4.8 @4.7 @4.6
  @storage
  Scenario Outline: PV with invalid volume id should be prevented from creating
    Given admin ensures "mypv" pv is deleted after scenario
    Given I obtain test data file "storage/<dir>/<file>"
    When I run the :create admin command with:
      | f | <file> |
    Then the step should fail
    And the output should contain:
      | <error> |

    @gcp-ipi
    @gcp-upi
    Examples:
      | case_id           | dir | file               | error                        |
      | OCP-10310:Storage | gce | pv-retain-rwx.json | error querying GCE PD volume | # @case_id OCP-10310
