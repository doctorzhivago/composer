(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� ]tY �]Y��ʶ���
��o��q�IQAAD�ƍ
f'AE���������*v�h��n43I�\��[+{e��d_��2���__� M��+J�����Bq�0%���c�W����<�&[�i���:�����ro��K�>���i7���`���2��q��)��+���������@�X�B�x%�2�n�?|P\.�$�J�e�B��}�W콣�r�h5���/���u��o���O�*���k���N�;�����q0U�w�~r-�=�h, (J��_����������ro��K�9�Fhsp�<��)�r	�i�)�!	�\�(!�i�d0�v<�tQ�	�&���W�u�!������?^{��?^�W���������ؐ՚�}P��	���S�4]h�(�H��&��I����V���l5�M[�Ta&��~ʧ1�<�j���@.6�&h!�S�J�MJO��<�Mt��h�C����@O�{<e��t�����24H���ֶޗ�.��P�Ȗ(z9�����;tj��
/��?�ѿ)~i��^4]�~�~�1����Q��_)�,��e\�^'~��o�������@*�_
�^�Y��Bm�j~Y����\�@(k�R�Y��2C�gͥ�m-��0\M�nO�0�BE�r��,�Դ�����A4��A �<��5L���x�Fdb�P�S�S�&mdq���!9�G��9�����Ev����A܉�q�jr@1�&��Z=7rw
G� �qEPr�x=X�b�#���4y���rK;
��[0Qx�Tv��й������i,"om졸�f`p�s�,�\Í���-�ܷ
�@��Y����_1��㡹7��R1���)n�M�'
�N_

�8�WňP�<�9���n$�)a7�a/�-��bc���9}���)�h'�rVr�P����]i�Y&n��Vw�t3עf��)�8��'�"�xy2�S4�E������3���'�K
P80y�(r�r�,��t�1)m�&Fv��Ê	��R=0�6H�\�h�D�i��&C!J !P�/k<y:9�����	t	#.b�fu0���n����ڹr�Iڒ�hj�x1��C&K f�ȱh�sfы��(�e��F�?=3��/��l���?��(^�)�$�?Jj����S��P��������'����G�y��S��]��H��9Zr;ˇr$��B?c�K����P�I9�S�bqU0U��"��~�Wf�}�"�;� Z�XX���+9$�MY���q��h1Qt+��)�)�a�P_�&N�&.�n��s���2�M���4���j�vZ�b�w� 4��[�.u��z��3w�V�J�Bx��К0
�-�G�H�-MSΌ�5 �$./�@���y����*�q���1�����8�t�܇�.��w|K3ymJ
�(�Hs?4���\rآQ��R�l�9��L�k|'p$�,���&��/�D�0����t��<�1>�@��亖L��)�fV}ȡ�a��?�����k���?��$IV���S������G��FЊ��@��W�������/��w�^��ZPB��%����e�?$MW�_)�����_���O�N����W'�)�-�:ASv@ ,и�`.�P�.J(F�GzU��?�2��������Ȯ��pA�����IA+G�	�2�x���
� 4.�7�|x1�g-[�m[����r�45~��Ko�R��d3D��/9��g�A�ۑ���s���W����v+�j� �n���iX��|�4��2����/�%�O��!+�_���j��Z����>���2����R�I���)�?��W
��3����̡�H�~!.�7[� -x������'��]>tl�0�Ѭ���31��B���d�G*��< }d�ex�I&��T�[ӹg�6|�=̝�*"��"	s=����z���dް��1�?M�B�x��	����NV�;�g���5�H��q9#�����@~���-�A�%�S�q�s ��l(bK Ӑ���s'������m�2	\X�7h�y��磅iϞ�P���I`*����;����C���b��v�in��:K{��,�;�!/7;��
�(!�D��|$s�"yY��	���@N�b�Ak����S���������2�)�������KA��W����������k����EЊ�K�%���_����ŵ��2P��������;����c[ A����+���ؤ�N?�0P>���v�����n��K�$�"��"B�,J�$I�U���2�y�B�xe�����T&��j�R��͉�1]0��cϑV�f?h�CO^���|�N�ǝ:���А�Q����2�F�	�6v�3�J������nO@�C���V>����3�pN)9��ͪ������S�O?�����&���r���H��)�X���������|�R�\�8AW�|T�o?��.�?��d%�2��i;����Q������a�����?�j��|��gi�.�#s�&]ƦX
u1
�\�e1���F�u� p�`���m�a}�Z(*e����9��T��|=.X��"�?��%�a��bB��vK#�Ļ���Jw�4Q?_����Є/�u�]q��ϥ��
t��yԘ	��G�׌�8��C0�2�v;Dت�L�5Aut_$�=��z���a|��i;��?����R�;�(I<��(��2�E��A���B�D���C	�i�7�`��?�������/��q�s�@��8�Z���� sߐ���<�}��ϒ ���?c�~�0�?���\�[7�nd���}t�zt4tw�Gρ�4���i疉��O}vJ��y�Jw�m�=b���t�o�0��"F�E7Ӭ����	5��D�Xo�Ql�f:Gm᭸h.)�74L��(g=�@�p[�G1��#�Gz�I��9|��I,̹����p�wk�ʹ�Q�hMX���UjS����ҝJ���9�[a��5� �RgD��ކ��t�w��n7�5���`��Ԝ��]]q��B[��n;i�圳�xJX9[��1�C�y��L;AO�%�����ӻ�����E�/��4����>S�����?�W�)�-�
���_3��[��%ʐ�������JU翗������������k���;��4r�����>}�ǽ��O��|�o �my�>��} �Gܖ�^��}�4��r���=8"1��C�MIiK[TwDck6�^�͵F߲���m{���L�ص4�aH���dNS�28�PеDr��8�I�� ��B��<���]j�?6�Y�|�9���f-x6���nڷW�`�5��\��^J�r��{���,�C��z}��{���46a�Dw�h�"����������_:�r���*����?�,����S�b�W����!�������������_��W�����:�b�ð�������ܺ���1
����RP��������[��P�������J���Ox�M���(�8�.C�F��O�L�8��C�O��#��b��`xu
�o�2�������_H�Z�)��J˔l99�[�Ԍa��"4����V�X�<�-j���c�鸭��+�{ɚ�zb��vp�*�(�9����Q���w-���3�(C�Sez��RGYl�C�j��G����O��%q�_���?��������/�V��U
�~�Z�[�o�o��t;u��T��6r��j���o��>�Ӆ��tl'��W��m�P7q�^#�ȕ�H&������2��s%��UM�.�7<�iv�;�]���^�᧧�8]g?����ķ�?�9�7��޷Z6�]�����Q;�w]�*R����t���|���~,t�+���������jWN�������$��v坺`/6������KNu��޷����ڞ.��fiGŨp훻ʠ����p;r���}cX��hluuA�E��!��:7�o�*]���#ק?/�>^�r_�fW�~��[E%��|��^�q������\;�BϾ��.:J�'߻��/o�d�y�,�3�^����o���:b��"{�e�%o�� ��O[/�������y��N���ͷWkӻ]�����zU������3�X��O[ �����SS�8�O��7M���8Y�a���	��.Nד�s]���L�GR��j�h�B"GE��L	����}7@���~�ȇ#�x쩛�NYo�c������	d��
�8��!�"v�w�h�<.��#��:����M��3B�+����r����$����N�t��ϖ�u�p����Ÿ�o{W�:Y��r���C	r9�e�p1�x��CE�n�v�n��7%מ�k�ukO�wb��L|	�7	!~ b������E��"h0ĈBL�h�m=��v���pA�s�{��������{����<�nڻ�7{I/6�Θ#���ܔ�A	���]!�,�L��H
�FÃ�xA�H2���.%ӑx׭mY;&�:z��"���2�N�q���ʹ�fet,����D�y�'����6!�v1a\ȇm�wTeI�{:884��6�����D�8�����[f&M7�� �Z-�m����L�,��V4]7um����8cg֫���;�$(�>��Lv�C�-d�4E��q	�
_e;R���,�7�h}0�׌3�U�=4��H�̪��5Π˰Ѳ��f�����!�PZ����YG�W�VE��{���Y^�M��h�|��t��o�t�M�)r8]�ɆSN���98�������trb��;�G�_'W�A���EEb�*wZ�E�}��\���c��j���e�u���_�2�&�t*i��H�s�ou�C֑�����sFO�T�x֜��H�2�4ҹ�+�5�o��2�+Q�5N�)F�`t������Շ��|m]p\r����T��2��c����M�z�b����\4([�(E������@]�9�Z�+7��9��ˑ~�S{����|U2�-�
�ÍF1���|vϹ����$�B��ɏ9)�:b!Cf<�Kp���:��2b�f�mN�4��޴��tx��Kǧ�}�a�+#��U{I6ta-*���B��.dy��>G����89���U�t?�}��C�y�(�sy�`�؟O>��{��w������Qc����?��������O��8x�Nl�Z{�ߏ��j絖J\x`���.��@�`,��E�U�uc�^�G�׳��V]����*���#��C9=�����Cgoo�vǙ_���ح��wO<����ڥG��9�
<C��J7����9�5�@8�C'��� ��š����9p�q��9���'��\���H�A���>=�Ծ�_���d}����Y�<0"�Ὠ�%�,ף��m��$^�0{����� ��a���6���e�z�����`#G$7C�6�%�n�3�,�Q��!�n�_��[��!��L��P;e��k`�4��Wɝ.��i2_�Q,S�׃���l���A�#pF��Ɇn�R�$�l����0GaJ����&j|?Mg��hG�X�)�A�/�����,
�L:;�+��f�(�ȄT*{j�l�G	�F)/�0,��-!&$=���,$�������C|��Ԕ'��z)D�!X.�G>e3am&�̈́]�	=} �n����E��Ԧ�:�Z�z�C�kvzK�.�����JȺUq0���h��d#n<(owœ�LR�n��2W��p_�#^���2A4�'Q��o5z��	%�L��6��|B"��CV�v�4�.�`�A"ԎdX��������+�CV�ل��l����A�
Amk�r<B�S�H��j���q�d%�U:�>�v�j�����D�@�)�apw=��cLd�m4�}e	��,ـuFY�ܙ�\w@
d���p*%����N488�������g�V4�v��6����P>�S-�IqJt���/B��ʠ
����g$:�%*B��*�h��1y<ӒRsʲGxFv��DU��h�7$	����V��9�`W'���p�I�8b*�`X-�;Q����J%#5?�k2�|�PM�}����
�ﭲ�)K����W��
�Ec=��|���Q�t�Y $(q����;)t�Z3�]���_I�|/5,��q%Z��vr�İR�������HLj�	 '܇S����I�A��j�,��7¤\�L�c�9e�#<#�TY��&��0��Ū�>-�T�{�,�+�k�%��7�p�9D���I��ɾ�T�6!�}�B�3#٤Ȗ#� ��$�����8m����l�m5�m�n�4'
�)��6�j�G�skWB�tJ�{b튍3�uӯ�V&A �.{�T�u��t��+��J�l�PUm���mN4B�r��]�v{]M���!T�����7�n�n7��+m\�F'7�7��B���j����AkSU]O�g���Ѳ��֡S�&K�%�ך��Ԇ<t3tz�?��s�هvX��:�,tf�*L~���d.��0�J���r��z]�Z�qL�gu�%3>1-3y��ʁ�;N㊢�Ũ�g�C/CF`Ō�C�C�.��DY5>�i�: �ڌ��?�#�_�[�ȍ������[����w˳_
엂�_
?p�-<���[$��3�.V�|+���le��}�AK	����Xt0�梃Ѡd�AO���`iς�Gu��I���iL7k� �=�w�{�1��7=4E��!�)5�Eҫz؈�EX)�E�@8R����hőh��~����WH�n!8�Ŕ�h^wn�u:�q%_�8Vh�c�rhd�:�����ᑠ�6���ӘI��ݣ&�C�±DM�05:D��g���ꪷC�fj9�i�:F��|>��O(�*q�2��T�q6�AZ��se�u�7�76���6D;�O�bB�%�[$��yյn��i
�$u�-��r�ǥ�V�c<��q8m㰍�6��X׮�t7t��T�2�\�6���c2�c�3���<�{�;t�[�2\��2����}���^���1�������ܗ�ò#i�Hڪ�Hf*8�6J�J)7p�K2�:�e؜�|�����b�KQ���`��>��D�Q�"�V�QPd�YS�՟c�w��Fm*	LL);q1D�A0�L��Ni��r&��tP8��Ѳ��/+]n�4��������/
�K)	�bB8Z��썅��Cvc!D����A���0!RcKM���pp�(O���nAy��._ڙ�+�Ŷ;"��|��R<���Byq�Y&�P�l�3� BW��B{���Ė��9@7Y����R.��t���V/�¾K;��a��a���q��q�F�Vr�܇v�fr��Z)$�B�m�"��ۅ�6e5��2m�õ;�-\���n�_G4�JE�5���^�\?���σ�q��$��-�M����Lw{}�\�W�Mҟ�I�t���^���G~��V�;>��/륧��]_z�/���q�Zc?�������f�ٴp��1�q ���]������%���g����Ko��� �x���M|󦿾��W�? z�$��8x*�~p�ڕޯ��䊞n��h:Q�m@g߈��O~�/6~'����_/��׿�'��)�����4E�|�	�9K�|զv��N��i�l��M����߿��i; mS;mj�M��}6�g{?P;ͷ��|�� U�B����z��&�&�A�-"�N21����L��1��=��_��^��&��<ۭ�y��T�S��3���6���gp��X���`9_�MM�Y�i�sf�h�=gƞ`O�����a�e�3s���G�s9f�\8�0�!Bk��6�]��1�9��_ju��b��Nv������M����+  