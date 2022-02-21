namespace java dev.vality.columbus
namespace erlang columbus

/**
* Идентификатор места по базе http://www.geonames.org/
**/
typedef i32 GeoID

typedef string IPAddress

/**
* GeoIsoCode - страна в формате ISO3166-1 Alpha 3
**/
typedef string GeoIsoCode

const GeoID GEO_ID_UNKNOWN = -1
const GeoIsoCode UNKNOWN = "UNKNOWN"

struct LocationInfo {
    // GeoID города
    1: required GeoID city_geo_id;
    // GeoID страны
    2: required GeoID country_geo_id;
    // Полное описание локации в json
    // подробное описание на сайте https://www.maxmind.com/en/geoip2-city
    3: optional string raw_response;
}

/**
 * Исключение, сигнализирующее о непригодных с точки зрения бизнес-логики входных данных
 */
exception InvalidRequest {
    /** Список пригодных для восприятия человеком ошибок во входных данных */
    1: required list<string> errors
}

/**
* Интерфейс Geo Service для клиентов - "Columbus"
*/
service ColumbusService {
    /**
    * Возвращает информацию о предполагаемом местоположении по IP
    * если IP некоректный то кидается InvalidRequest с этим IP
    * если для IP не найдена страна или город то в LocationInfo, данное поле будет иметь значение GEO_ID_UNKNOWN
    **/
    LocationInfo GetLocation (1: IPAddress ip) throws (1: InvalidRequest ex1)

    /**
    *  то же что и GetLocation, но для списка IP адресов
    **/
    map <IPAddress, LocationInfo> GetLocations (1: set <IPAddress> ip) throws (1: InvalidRequest ex1)

    /**
    * Возвращает iso code страны местоположения по IP
    * если IP некоректный то кидается InvalidRequest с этим IP
    * если для IP не найдена iso code будет равен UNKNOWN
    **/
    GeoIsoCode GetLocationIsoCode (1: IPAddress ip) throws (1: InvalidRequest ex1)
}