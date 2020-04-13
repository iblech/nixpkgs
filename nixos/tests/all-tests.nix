{ system, pkgs, callTest }:
# The return value of this function will be an attrset with arbitrary depth and
# the `anything` returned by callTest at its test leafs.
# The tests not supported by `system` will be replaced with `{}`, so that
# `passthru.tests` can contain links to those without breaking on architectures
# where said tests are unsupported.
# Example callTest that just extracts the derivation from the test:
#   callTest = t: t.test;

with pkgs.lib;

let
  discoverTests = val:
    if !isAttrs val then val
    else if hasAttr "test" val then callTest val
    else mapAttrs (n: s: discoverTests s) val;
  handleTest = path: args:
    discoverTests (import path ({ inherit system pkgs; } // args));
  handleTestOn = systems: path: args:
    if elem system systems then handleTest path args
    else {};
in
{
  _3proxy = handleTest ./3proxy.nix {};
  acme = handleTestOn ["x86_64-linux"] ./acme.nix {};
  atd = handleTest ./atd.nix {};
  automysqlbackup = handleTest ./automysqlbackup.nix {};
  avahi = handleTest ./avahi.nix {};
  babeld = handleTest ./babeld.nix {};
  bcachefs = handleTestOn ["x86_64-linux"] ./bcachefs.nix {}; # linux-4.18.2018.10.12 is unsupported on aarch64
  beanstalkd = handleTest ./beanstalkd.nix {};
  bees = handleTest ./bees.nix {};
  bind = handleTest ./bind.nix {};
  bittorrent = handleTest ./bittorrent.nix {};
  buildkite-agents = handleTest ./buildkite-agents.nix {};
  boot = handleTestOn ["x86_64-linux"] ./boot.nix {}; # syslinux is unsupported on aarch64
  boot-stage1 = handleTest ./boot-stage1.nix {};
  borgbackup = handleTest ./borgbackup.nix {};
  buildbot = handleTest ./buildbot.nix {};
  caddy = handleTest ./caddy.nix {};
  cadvisor = handleTestOn ["x86_64-linux"] ./cadvisor.nix {};
  cage = handleTest ./cage.nix {};
  cassandra = handleTest ./cassandra.nix {};
  ceph-single-node = handleTestOn ["x86_64-linux"] ./ceph-single-node.nix {};
  ceph-multi-node = handleTestOn ["x86_64-linux"] ./ceph-multi-node.nix {};
  certmgr = handleTest ./certmgr.nix {};
  cfssl = handleTestOn ["x86_64-linux"] ./cfssl.nix {};
  chromium = (handleTestOn ["x86_64-linux"] ./chromium.nix {}).stable or {};
  cjdns = handleTest ./cjdns.nix {};
  clickhouse = handleTest ./clickhouse.nix {};
  cloud-init = handleTest ./cloud-init.nix {};
  codimd = handleTest ./codimd.nix {};
  consul = handleTest ./consul.nix {};
  containers-bridge = handleTest ./containers-bridge.nix {};
  containers-ephemeral = handleTest ./containers-ephemeral.nix {};
  containers-extra_veth = handleTest ./containers-extra_veth.nix {};
  containers-hosts = handleTest ./containers-hosts.nix {};
  containers-imperative = handleTest ./containers-imperative.nix {};
  containers-ip = handleTest ./containers-ip.nix {};
  containers-macvlans = handleTest ./containers-macvlans.nix {};
  containers-physical_interfaces = handleTest ./containers-physical_interfaces.nix {};
  containers-portforward = handleTest ./containers-portforward.nix {};
  containers-restart_networking = handleTest ./containers-restart_networking.nix {};
  containers-tmpfs = handleTest ./containers-tmpfs.nix {};
  corerad = handleTest ./corerad.nix {};
  couchdb = handleTest ./couchdb.nix {};
  deluge = handleTest ./deluge.nix {};
  dhparams = handleTest ./dhparams.nix {};
  dnscrypt-proxy2 = handleTestOn ["x86_64-linux"] ./dnscrypt-proxy2.nix {};
  docker = handleTestOn ["x86_64-linux"] ./docker.nix {};
  docker-containers = handleTestOn ["x86_64-linux"] ./docker-containers.nix {};
  docker-edge = handleTestOn ["x86_64-linux"] ./docker-edge.nix {};
  docker-preloader = handleTestOn ["x86_64-linux"] ./docker-preloader.nix {};
  docker-registry = handleTest ./docker-registry.nix {};
  docker-tools = handleTestOn ["x86_64-linux"] ./docker-tools.nix {};
  docker-tools-overlay = handleTestOn ["x86_64-linux"] ./docker-tools-overlay.nix {};
  documize = handleTest ./documize.nix {};
  dokuwiki = handleTest ./dokuwiki.nix {};
  dovecot = handleTest ./dovecot.nix {};
  # ec2-config doesn't work in a sandbox as the simulated ec2 instance needs network access
  #ec2-config = (handleTestOn ["x86_64-linux"] ./ec2.nix {}).boot-ec2-config or {};
  ec2-nixops = (handleTestOn ["x86_64-linux"] ./ec2.nix {}).boot-ec2-nixops or {};
  ecryptfs = handleTest ./ecryptfs.nix {};
  ejabberd = handleTest ./xmpp/ejabberd.nix {};
  elk = handleTestOn ["x86_64-linux"] ./elk.nix {};
  env = handleTest ./env.nix {};
  etcd = handleTestOn ["x86_64-linux"] ./etcd.nix {};
  etcd-cluster = handleTestOn ["x86_64-linux"] ./etcd-cluster.nix {};
  fancontrol = handleTest ./fancontrol.nix {};
  ferm = handleTest ./ferm.nix {};
  firefox = handleTest ./firefox.nix {};
  firefox-esr = handleTest ./firefox.nix { esr = true; };
  firewall = handleTest ./firewall.nix {};
  fish = handleTest ./fish.nix {};
  flannel = handleTestOn ["x86_64-linux"] ./flannel.nix {};
  fluentd = handleTest ./fluentd.nix {};
  fontconfig-default-fonts = handleTest ./fontconfig-default-fonts.nix {};
  freeswitch = handleTest ./freeswitch.nix {};
  fsck = handleTest ./fsck.nix {};
  gerrit = handleTest ./gerrit.nix {};
  gotify-server = handleTest ./gotify-server.nix {};
  grocy = handleTest ./grocy.nix {};
  gitdaemon = handleTest ./gitdaemon.nix {};
  gitea = handleTest ./gitea.nix {};
  gitlab = handleTest ./gitlab.nix {};
  gitolite = handleTest ./gitolite.nix {};
  gitolite-fcgiwrap = handleTest ./gitolite-fcgiwrap.nix {};
  glusterfs = handleTest ./glusterfs.nix {};
  gnome3-xorg = handleTest ./gnome3-xorg.nix {};
  gnome3 = handleTest ./gnome3.nix {};
  installed-tests = pkgs.recurseIntoAttrs (handleTest ./installed-tests {});
  gocd-agent = handleTest ./gocd-agent.nix {};
  gocd-server = handleTest ./gocd-server.nix {};
  google-oslogin = handleTest ./google-oslogin {};
  grafana = handleTest ./grafana.nix {};
  graphite = handleTest ./graphite.nix {};
  graylog = handleTest ./graylog.nix {};
  gvisor = handleTest ./gvisor.nix {};
  hadoop.hdfs = handleTestOn [ "x86_64-linux" ] ./hadoop/hdfs.nix {};
  hadoop.yarn = handleTestOn [ "x86_64-linux" ] ./hadoop/yarn.nix {};
  handbrake = handleTestOn ["x86_64-linux"] ./handbrake.nix {};
  haproxy = handleTest ./haproxy.nix {};
  hardened = handleTest ./hardened.nix {};
  # 9pnet_virtio used to mount /nix partition doesn't support
  # hibernation. This test happens to work on x86_64-linux but
  # not on other platforms.
  hibernate = handleTestOn ["x86_64-linux"] ./hibernate.nix {};
  hitch = handleTest ./hitch {};
  hocker-fetchdocker = handleTest ./hocker-fetchdocker {};
  home-assistant = handleTest ./home-assistant.nix {};
  hound = handleTest ./hound.nix {};
  hydra = handleTest ./hydra {};
  hydra-db-migration = handleTest ./hydra/db-migration.nix {};
  i3wm = handleTest ./i3wm.nix {};
  icingaweb2 = handleTest ./icingaweb2.nix {};
  iftop = handleTest ./iftop.nix {};
  ihatemoney = handleTest ./ihatemoney.nix {};
  incron = handleTest ./incron.nix {};
  influxdb = handleTest ./influxdb.nix {};
  initrd-network-ssh = handleTest ./initrd-network-ssh {};
  initrdNetwork = handleTest ./initrd-network.nix {};
  installer = handleTest ./installer.nix {};
  iodine = handleTest ./iodine.nix {};
  ipv6 = handleTest ./ipv6.nix {};
  jackett = handleTest ./jackett.nix {};
  jellyfin = handleTest ./jellyfin.nix {};
  jenkins = handleTest ./jenkins.nix {};
  jirafeau = handleTest ./jirafeau.nix {};
  kafka = handleTest ./kafka.nix {};
  keepalived = handleTest ./keepalived.nix {};
  kerberos = handleTest ./kerberos/default.nix {};
  kernel-latest = handleTest ./kernel-latest.nix {};
  kernel-lts = handleTest ./kernel-lts.nix {};
  kernel-testing = handleTest ./kernel-testing.nix {};
  keymap = handleTest ./keymap.nix {};
  knot = handleTest ./knot.nix {};
  krb5 = discoverTests (import ./krb5 {});
  kubernetes.dns = handleTestOn ["x86_64-linux"] ./kubernetes/dns.nix {};
  # kubernetes.e2e should eventually replace kubernetes.rbac when it works
  #kubernetes.e2e = handleTestOn ["x86_64-linux"] ./kubernetes/e2e.nix {};
  kubernetes.rbac = handleTestOn ["x86_64-linux"] ./kubernetes/rbac.nix {};
  latestKernel.login = handleTest ./login.nix { latestKernel = true; };
  ldap = handleTest ./ldap.nix {};
  leaps = handleTest ./leaps.nix {};
  lidarr = handleTest ./lidarr.nix {};
  lightdm = handleTest ./lightdm.nix {};
  limesurvey = handleTest ./limesurvey.nix {};
  login = handleTest ./login.nix {};
  loki = handleTest ./loki.nix {};
  #logstash = handleTest ./logstash.nix {};
  lorri = handleTest ./lorri/default.nix {};
  magnetico = handleTest ./magnetico.nix {};
  magic-wormhole-mailbox-server = handleTest ./magic-wormhole-mailbox-server.nix {};
  mailcatcher = handleTest ./mailcatcher.nix {};
  mathics = handleTest ./mathics.nix {};
  matomo = handleTest ./matomo.nix {};
  matrix-synapse = handleTest ./matrix-synapse.nix {};
  mediawiki = handleTest ./mediawiki.nix {};
  memcached = handleTest ./memcached.nix {};
  mesos = handleTest ./mesos.nix {};
  metabase = handleTest ./metabase.nix {};
  miniflux = handleTest ./miniflux.nix {};
  minio = handleTest ./minio.nix {};
  minidlna = handleTest ./minidlna.nix {};
  misc = handleTest ./misc.nix {};
  moinmoin = handleTest ./moinmoin.nix {};
  mongodb = handleTest ./mongodb.nix {};
  moodle = handleTest ./moodle.nix {};
  morty = handleTest ./morty.nix {};
  mosquitto = handleTest ./mosquitto.nix {};
  mpd = handleTest ./mpd.nix {};
  mumble = handleTest ./mumble.nix {};
  munin = handleTest ./munin.nix {};
  mutableUsers = handleTest ./mutable-users.nix {};
  mxisd = handleTest ./mxisd.nix {};
  mysql = handleTest ./mysql.nix {};
  mysqlBackup = handleTest ./mysql-backup.nix {};
  mysqlReplication = handleTest ./mysql-replication.nix {};
  nagios = handleTest ./nagios.nix {};
  nat.firewall = handleTest ./nat.nix { withFirewall = true; };
  nat.firewall-conntrack = handleTest ./nat.nix { withFirewall = true; withConntrackHelpers = true; };
  nat.standalone = handleTest ./nat.nix { withFirewall = false; };
  ndppd = handleTest ./ndppd.nix {};
  neo4j = handleTest ./neo4j.nix {};
  specialisation = handleTest ./specialisation.nix {};
  netdata = handleTest ./netdata.nix {};
  networking.networkd = handleTest ./networking.nix { networkd = true; };
  networking.scripted = handleTest ./networking.nix { networkd = false; };
  # TODO: put in networking.nix after the test becomes more complete
  networkingProxy = handleTest ./networking-proxy.nix {};
  nextcloud = handleTest ./nextcloud {};
  nexus = handleTest ./nexus.nix {};
  # TODO: Test nfsv3 + Kerberos
  nfs3 = handleTest ./nfs { version = 3; };
  nfs4 = handleTest ./nfs { version = 4; };
  nghttpx = handleTest ./nghttpx.nix {};
  nginx = handleTest ./nginx.nix {};
  nginx-etag = handleTest ./nginx-etag.nix {};
  nginx-pubhtml = handleTest ./nginx-pubhtml.nix {};
  nginx-sso = handleTest ./nginx-sso.nix {};
  nix-ssh-serve = handleTest ./nix-ssh-serve.nix {};
  nixos-generate-config = handleTest ./nixos-generate-config.nix {};
  novacomd = handleTestOn ["x86_64-linux"] ./novacomd.nix {};
  nsd = handleTest ./nsd.nix {};
  nzbget = handleTest ./nzbget.nix {};
  openarena = handleTest ./openarena.nix {};
  openldap = handleTest ./openldap.nix {};
  opensmtpd = handleTest ./opensmtpd.nix {};
  openssh = handleTest ./openssh.nix {};
  openstack-image-userdata = (handleTestOn ["x86_64-linux"] ./openstack-image.nix {}).userdata or {};
  openstack-image-metadata = (handleTestOn ["x86_64-linux"] ./openstack-image.nix {}).metadata or {};
  orangefs = handleTest ./orangefs.nix {};
  os-prober = handleTestOn ["x86_64-linux"] ./os-prober.nix {};
  osrm-backend = handleTest ./osrm-backend.nix {};
  overlayfs = handleTest ./overlayfs.nix {};
  packagekit = handleTest ./packagekit.nix {};
  pam-oath-login = handleTest ./pam-oath-login.nix {};
  pam-u2f = handleTest ./pam-u2f.nix {};
  pantheon = handleTest ./pantheon.nix {};
  paperless = handleTest ./paperless.nix {};
  peerflix = handleTest ./peerflix.nix {};
  pgjwt = handleTest ./pgjwt.nix {};
  pgmanage = handleTest ./pgmanage.nix {};
  php = handleTest ./php {};
  plasma5 = handleTest ./plasma5.nix {};
  plotinus = handleTest ./plotinus.nix {};
  postgis = handleTest ./postgis.nix {};
  postgresql = handleTest ./postgresql.nix {};
  postgresql-wal-receiver = handleTest ./postgresql-wal-receiver.nix {};
  powerdns = handleTest ./powerdns.nix {};
  pppd = handleTest ./pppd.nix {};
  predictable-interface-names = handleTest ./predictable-interface-names.nix {};
  printing = handleTest ./printing.nix {};
  prometheus = handleTest ./prometheus.nix {};
  prometheus-exporters = handleTest ./prometheus-exporters.nix {};
  prosody = handleTest ./xmpp/prosody.nix {};
  prosodyMysql = handleTest ./xmpp/prosody-mysql.nix {};
  proxy = handleTest ./proxy.nix {};
  quagga = handleTest ./quagga.nix {};
  quorum = handleTest ./quorum.nix {};
  rabbitmq = handleTest ./rabbitmq.nix {};
  radarr = handleTest ./radarr.nix {};
  radicale = handleTest ./radicale.nix {};
  redis = handleTest ./redis.nix {};
  redmine = handleTest ./redmine.nix {};
  restic = handleTest ./restic.nix {};
  roundcube = handleTest ./roundcube.nix {};
  rspamd = handleTest ./rspamd.nix {};
  rss2email = handleTest ./rss2email.nix {};
  rsyslogd = handleTest ./rsyslogd.nix {};
  runInMachine = handleTest ./run-in-machine.nix {};
  rxe = handleTest ./rxe.nix {};
  samba = handleTest ./samba.nix {};
  sanoid = handleTest ./sanoid.nix {};
  sddm = handleTest ./sddm.nix {};
  service-runner = handleTest ./service-runner.nix {};
  shiori = handleTest ./shiori.nix {};
  signal-desktop = handleTest ./signal-desktop.nix {};
  simple = handleTest ./simple.nix {};
  slurm = handleTest ./slurm.nix {};
  smokeping = handleTest ./smokeping.nix {};
  snapper = handleTest ./snapper.nix {};
  solr = handleTest ./solr.nix {};
  spacecookie = handleTest ./spacecookie.nix {};
  sonarr = handleTest ./sonarr.nix {};
  strongswan-swanctl = handleTest ./strongswan-swanctl.nix {};
  sudo = handleTest ./sudo.nix {};
  switchTest = handleTest ./switch-test.nix {};
  sympa = handleTest ./sympa.nix {};
  syncthing-init = handleTest ./syncthing-init.nix {};
  syncthing-relay = handleTest ./syncthing-relay.nix {};
  systemd = handleTest ./systemd.nix {};
  systemd-analyze = handleTest ./systemd-analyze.nix {};
  systemd-confinement = handleTest ./systemd-confinement.nix {};
  systemd-timesyncd = handleTest ./systemd-timesyncd.nix {};
  systemd-networkd-vrf = handleTest ./systemd-networkd-vrf.nix {};
  systemd-networkd = handleTest ./systemd-networkd.nix {};
  systemd-nspawn = handleTest ./systemd-nspawn.nix {};
  pdns-recursor = handleTest ./pdns-recursor.nix {};
  taskserver = handleTest ./taskserver.nix {};
  telegraf = handleTest ./telegraf.nix {};
  tiddlywiki = handleTest ./tiddlywiki.nix {};
  timezone = handleTest ./timezone.nix {};
  tinydns = handleTest ./tinydns.nix {};
  tor = handleTest ./tor.nix {};
  transmission = handleTest ./transmission.nix {};
  trac = handleTest ./trac.nix {};
  trilium-server = handleTestOn ["x86_64-linux"] ./trilium-server.nix {};
  trezord = handleTest ./trezord.nix {};
  trickster = handleTest ./trickster.nix {};
  udisks2 = handleTest ./udisks2.nix {};
  upnp = handleTest ./upnp.nix {};
  uwsgi = handleTest ./uwsgi.nix {};
  vault = handleTest ./vault.nix {};
  victoriametrics = handleTest ./victoriametrics.nix {};
  virtualbox = handleTestOn ["x86_64-linux"] ./virtualbox.nix {};
  tigervnc = handleTest ./tigervnc.nix {};
  wg-quick = handleTest ./wireguard/wg-quick.nix {};
  wireguard = handleTest ./wireguard {};
  wireguard-generated = handleTest ./wireguard/generated.nix {};
  wireguard-namespaces = handleTest ./wireguard/namespaces.nix {};
  wordpress = handleTest ./wordpress.nix {};
  xandikos = handleTest ./xandikos.nix {};
  xautolock = handleTest ./xautolock.nix {};
  xfce = handleTest ./xfce.nix {};
  xmonad = handleTest ./xmonad.nix {};
  xrdp = handleTest ./xrdp.nix {};
  xss-lock = handleTest ./xss-lock.nix {};
  yabar = handleTest ./yabar.nix {};
  yggdrasil = handleTest ./yggdrasil.nix {};
  zfs = handleTest ./zfs.nix {};
  zsh-history = handleTest ./zsh-history.nix {};
  zookeeper = handleTest ./zookeeper.nix {};
}
