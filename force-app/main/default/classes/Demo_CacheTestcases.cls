/**
 * @description Profiling examples.
 * @author Daniel Stange
 * @date 2019-08-02
 */
public class Demo_CacheTestcases {

    /**
     * @description Invokes 100 retrieves of single items in various acess/retrieval modes
     *
     * @param mode retrieval mode (map = bulkified cache, item = single item cache, db = bulkifi)ed DB access, dbsingle = non-bulkified DB access
     */
    public static void retrieveCachedFromMemory(String mode) {

        List<Long> elapsedTime = new List<Long>();
        String s;

        for (Integer i = 0; i < 100; i++) {

            if ((Limits.getLimitCpuTime() - Limits.getCpuTime() ) < 500) {
                System.debug('Skipped at index ' + i + ' because of CPU time issues');
                break;
            }

            String key = String.valueOf(
                    ((7500 * Math.random()).round())
            );
            Long time1, time2;
            Id pId;

            if (mode == 'map') {
                time1 = System.currentTimeMillis();
                pId = Demo_Cache.getProductId(key);
                time2 = System.currentTimeMillis();
            } else if (mode == 'item') {
                time1 = System.currentTimeMillis();
                pId = Demo_Cache.getProductIdPerItem(key);
                time2 = System.currentTimeMillis();
            } else if (mode == 'db') {
                time1 = System.currentTimeMillis();
                pId = Demo_Cache.getProductFromDB(key);
                time2 = System.currentTimeMillis();
            } else if (mode == 'dbsingle') {
                time1 = System.currentTimeMillis();
                pId = Demo_Cache.getSingleProductFromDB(key);
                time2 = System.currentTimeMillis();
            } else if (mode == 'interface') {
                time1 = System.currentTimeMillis();
                Product2 p = (Product2) Cache.Org.get(Cache_ProductCode.class, key);
                time2 = System.currentTimeMillis();
            }

            elapsedTime.add((time2 - time1));
        }

        for (Long l : elapsedTime) {
            s += String.valueOf(l) + '\n';
        }
        insert new Case(
                Description = s,
                Subject = 'Retrieved from Cache via Map',
                Origin = 'Web'
        );
    }

}