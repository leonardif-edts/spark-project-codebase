import sys
import importlib

if __name__ == "__main__":
    _, job_name, *args = sys.argv
    
    job = importlib.import_module(f"jobs.{job_name}.main")
    job.run(**job.get_args())
