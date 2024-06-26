circom health_check.circom --r1cs --wasm --sym -o ./output/
node ./output/health_check_js/generate_witness.js ./output/health_check_js/health_check.wasm ./input/input.json ./output/witness.wtns
cd ./output/
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="Roshan Parajuli" -v
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
snarkjs groth16 setup health_check.r1cs pot12_final.ptau health_check_0000.zkey
snarkjs zkey contribute health_check_0000.zkey health_check_0001.zkey --name="Roshan Parajuli" -v
snarkjs zkey export verificationkey health_check_0001.zkey verification_key.json
snarkjs groth16 prove health_check_0001.zkey witness.wtns proof.json public.json
snarkjs groth16 verify verification_key.json public.json proof.json
cd ../node/; npm i; node ./generator.js