# frozen_string_literal: true

require 'spec_helper'

describe 'Export Gateways', type: :feature do
  include_context :login_as_admin

  before { create(:gateway) }

  let(:contractor) { create(:vendor) }

  let!(:item) do
    create :gateway,
           contractor: contractor,
           gateway_group: create(:gateway_group, vendor: contractor),
           pop: Pop.take,
           session_refresh_method: SessionRefreshMethod.take,
           sensor: create(:sensor),
           orig_disconnect_policy: create(:disconnect_policy),
           term_disconnect_policy: create(:disconnect_policy)
  end

  before do
    visit gateways_path(format: :csv)
  end

  subject { CSV.parse(page.body).slice(0, 2).transpose }

  it 'has expected header and values' do
    expect(subject).to match_array(
      [
        ['Id',                                 item.id.to_s],
        ['Name',                               item.name],
        ['Enabled',                            item.enabled.to_s],
        ['Gateway group name',                 item.gateway_group.name],
        ['Priority',                           item.priority.to_s],
        ['Weight',                             item.weight.to_s],
        ['Pop name',                           item.pop.name],
        ['Contractor name',                    item.contractor.name],
        ['Is shared',                          item.is_shared.to_s],
        ['Allow origination',                  item.allow_origination.to_s],
        ['Allow termination',                  item.allow_termination.to_s],
        ['Sst enabled',                        item.sst_enabled.to_s],
        ['Origination capacity',               item.origination_capacity.to_s],
        ['Termination capacity',               item.termination_capacity.to_s],
        ['Acd limit',                          item.acd_limit.to_s],
        ['Asr limit',                          item.asr_limit.to_s],
        ['Short calls limit',                  item.short_calls_limit.to_s],
        ['Sst session expires',                item.sst_session_expires.to_s],
        ['Sst minimum timer',                  item.sst_minimum_timer.to_s],
        ['Sst maximum timer',                  item.sst_maximum_timer.to_s],
        ['Session refresh method name',        item.session_refresh_method.name],
        ['Sst accept501',                      item.sst_accept501.to_s],
        ['Sensor level name',                  item.sensor_level.name],
        ['Sensor name',                        item.sensor.name],
        ['Orig next hop',                      item.orig_next_hop.to_s],
        ['Orig append headers req',            item.orig_append_headers_req.to_s],
        ['Orig use outbound proxy',            item.orig_use_outbound_proxy.to_s],
        ['Orig force outbound proxy',          item.orig_force_outbound_proxy.to_s],
        ['Orig proxy transport protocol name', item.orig_proxy_transport_protocol.name],
        ['Orig outbound proxy',                item.orig_outbound_proxy.to_s],
        ['Dialog nat handling',                item.dialog_nat_handling.to_s],
        ['Orig disconnect policy name',        item.orig_disconnect_policy.name],
        ['Transport protocol name',            item.transport_protocol.name],
        ['Host',                               item.host],
        ['Port',                               item.port.to_s],
        ['Resolve ruri',                       item.resolve_ruri.to_s],
        ['Diversion policy name',              item.diversion_policy.name],
        ['Diversion rewrite rule',             item.diversion_rewrite_rule.to_s],
        ['Diversion rewrite result',           item.diversion_rewrite_result.to_s],
        ['Src name rewrite rule',              item.src_name_rewrite_rule.to_s],
        ['Src name rewrite result',            item.src_name_rewrite_result.to_s],
        ['Src rewrite rule',                   item.src_rewrite_rule.to_s],
        ['Src rewrite result',                 item.src_rewrite_result.to_s],
        ['Dst rewrite rule',                   item.dst_rewrite_rule.to_s],
        ['Dst rewrite result',                 item.dst_rewrite_result.to_s],
        ['Auth enabled',                       item.auth_enabled.to_s],
        ['Auth user',                          item.auth_user.to_s],
        ['Auth password',                      item.auth_password.to_s],
        ['Auth from user',                     item.auth_from_user.to_s],
        ['Auth from domain',                   item.auth_from_domain.to_s],
        ['Incoming auth username',             item.incoming_auth_username.to_s],
        ['Incoming auth password',             item.incoming_auth_password.to_s],
        ['Term use outbound proxy',            item.term_use_outbound_proxy.to_s],
        ['Term force outbound proxy',          item.term_force_outbound_proxy.to_s],
        ['Term proxy transport protocol name', item.term_proxy_transport_protocol.name],
        ['Term outbound proxy',                item.term_outbound_proxy.to_s],
        ['Term next hop for replies',          item.term_next_hop_for_replies.to_s],
        ['Term next hop',                      item.term_next_hop.to_s],
        ['Term disconnect policy name',        item.term_disconnect_policy.name],
        ['Term append headers req',            item.term_append_headers_req.to_s],
        ['Sdp alines filter type name',        item.sdp_alines_filter_type.name],
        ['Sdp alines filter list',             item.sdp_alines_filter_list.to_s],
        ['Ringing timeout',                    item.ringing_timeout.to_s],
        ['Relay options',                      item.relay_options.to_s],
        ['Relay reinvite',                     item.relay_reinvite.to_s],
        ['Relay hold',                         item.relay_hold.to_s],
        ['Relay prack',                        item.relay_prack.to_s],
        ['Rel100 mode name',                   item.rel100_mode.name],
        ['Relay update',                       item.relay_update.to_s],
        ['Allow 1xx without to tag',           item.allow_1xx_without_to_tag.to_s],
        ['Sip timer b',                        item.sip_timer_b.to_s],
        ['Dns srv failover timer',             item.dns_srv_failover_timer.to_s],
        ['Sdp c location name',                item.sdp_c_location.name],
        ['Codec group name',                   item.codec_group.name],
        ['Anonymize sdp',                      item.anonymize_sdp.to_s],
        ['Proxy media',                        item.proxy_media.to_s],
        ['Single codec in 200ok',              item.single_codec_in_200ok.to_s],
        ['Transparent seqno',                  item.transparent_seqno.to_s],
        ['Transparent ssrc',                   item.transparent_ssrc.to_s],
        ['Force symmetric rtp',                item.force_symmetric_rtp.to_s],
        ['Symmetric rtp nonstop',              item.symmetric_rtp_nonstop.to_s],
        ['Symmetric rtp ignore rtcp',          item.symmetric_rtp_ignore_rtcp.to_s],
        ['Force dtmf relay',                   item.force_dtmf_relay.to_s],
        ['Rtp ping',                           item.rtp_ping.to_s],
        ['Rtp timeout',                        item.rtp_timeout.to_s],
        ['Filter noaudio streams',             item.filter_noaudio_streams.to_s],
        ['Rtp relay timestamp aligning',       item.rtp_relay_timestamp_aligning.to_s],
        ['Rtp force relay cn',                 item.rtp_force_relay_cn.to_s],
        ['Dtmf send mode name',                item.dtmf_send_mode.name],
        ['Dtmf receive mode name',             item.dtmf_receive_mode.name],
        ['Tx inband dtmf filtering mode',      item.tx_inband_dtmf_filtering_mode.name],
        ['Rx inband dtmf filtering mode',      item.rx_inband_dtmf_filtering_mode.name],
        ['Suppress early media',               item.suppress_early_media.to_s],
        ['Send lnp information',               item.send_lnp_information.to_s],
        ['Force one way early media',          item.force_one_way_early_media.to_s],
        ['Max 30x redirects',                  item.max_30x_redirects.to_s],
        ['Media encryption mode',              item.media_encryption_mode.name],
        ['Network protocol priority name',     item.network_protocol_priority.name],
        ['Sip schema name',                    item.sip_schema.name]
      ]
    )
  end
end