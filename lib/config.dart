class Config {
  final String urlApi;
  final String urlLocal;
  final String urlRemote;
  final String env;

  Config({
    this.urlApi = '',
    this.urlRemote = 'http://recyclerappbga.com/',
    this.urlLocal = 'http://localhost:80/',
    this.env = 'remote',
  });

  getApiUrl() {
    switch (env) {
      case 'local':
        return urlLocal;
      case 'remote':
        return urlRemote;
      default:
        print('Error: ENV not set');
        return urlLocal;
    }
  }
}
